import json
import os
from flask import Flask, request, render_template, jsonify
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)

# Đường dẫn đến file JSON
DATA_FILE = "data.json"

# Khởi tạo file JSON nếu chưa tồn tại
def init_data_file():
    initial_data = {"dna_read": "", "dna_reference": "", "matrix": [], "received_bits": ""}
    with open(DATA_FILE, 'w') as f:
        json.dump(initial_data, f)

# Đọc dữ liệu từ file
def read_data():
    with open(DATA_FILE, 'r') as f:
        return json.load(f)

# Ghi dữ liệu vào file
def write_data(data):
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f)

# Khởi tạo file khi ứng dụng chạy
init_data_file()

# Hàm chuyển đổi DNA sang nhị phân
def dna_to_binary(sequence):
    dna_binary = {'A': '00', 'T': '11', 'G': '01', 'C': '10', 'X': '10'}
    return ''.join(dna_binary.get(base.upper(), '') for base in sequence)

def encode_dna(sequence):
    return {'original': str(sequence), 'binary': dna_to_binary(str(sequence))}

def smith_waterman(seq1, seq2, score_matrix):
    rows = len(seq2)
    cols = len(seq1)

    # Sử dụng score_matrix đã cung cấp làm ma trận H
    H = [[score_matrix[i][j] for j in range(cols)] for i in range(rows)]

    # Tìm ô có giá trị lớn nhất để bắt đầu backtracking
    max_score = 0
    max_i, max_j = 0, 0
    for i in range(rows):
        for j in range(cols):
            if H[i][j] > max_score:
                max_score = H[i][j]
                max_i, max_j = i, j

    # Backtracking để tìm chuỗi con
    align1, align2 = [], []
    i, j = max_i, max_j
    while i >= 0 and j >= 0 and H[i][j] > 0:
        align1.append(seq1[j])
        align2.append(seq2[i])

        # Tìm giá trị lớn nhất trong các ô liền kề
        diagonal = H[i-1][j-1] if i > 0 and j > 0 else float('-inf')
        up = H[i-1][j] if i > 0 else float('-inf')
        left = H[i][j-1] if j > 0 else float('-inf')

        # Chỉ đi theo hướng có giá trị lớn nhất và nhỏ hơn giá trị hiện tại
        max_neighbor = max(diagonal, up, left)
        if max_neighbor >= H[i][j] or max_neighbor == float('-inf'):
            break  # Không có hướng nào hợp lệ, dừng lại

        if max_neighbor == diagonal and i > 0 and j > 0:
            i -= 1
            j -= 1
        elif max_neighbor == up and i > 0:
            i -= 1
            align1[-1] = '-'
        elif max_neighbor == left and j > 0:
            j -= 1
            align2[-1] = '-'

    # Đảo ngược chuỗi vì backtracking đi ngược
    align_read = ''.join(reversed(align1))
    align_ref = ''.join(reversed(align2))

    # Tạo chuỗi match để hiển thị mức độ tương đồng
    match = ''
    for a, b in zip(align_read, align_ref):
        if a == b and a != '-':
            match += '*'
        elif a != '-' and b != '-':
            match += ' '
        else:
            match += '|'

    # Kết hợp chuỗi match vào kết quả
    align_result = f"{align_read} {match} {align_ref}"

    return H, max_score, align_read, align_ref, align_result
@app.route('/', methods=['GET', 'POST'])
def upload_files():
    data = read_data()
    if request.method == 'POST':
        results = []
        file_types = ['dna_read', 'dna_reference']
        for file_type in file_types:
            if file_type in request.files:
                file = request.files[file_type]
                if file:
                    content = file.read().decode('utf-8').strip()
                    display_name = 'DNA Read' if file_type == 'dna_read' else 'DNA Reference'
                    encoding = encode_dna(content)
                    results.append({'filename': display_name, 'encoding': encoding})
                    if file_type == 'dna_read':
                        data['dna_read'] = content
                    else:
                        data['dna_reference'] = content
        # Khởi tạo ma trận
        dna_read = data.get('dna_read', '')
        dna_reference = data.get('dna_reference', '')
        rows = len(dna_reference) if dna_reference else 0
        cols = len(dna_read) if dna_read else 0
        if rows > 0 and cols > 0:
            if not data.get('matrix') or len(data.get('matrix', [])) != rows or len(data.get('matrix', [[]])[0]) != cols:
                data['matrix'] = [[0 for _ in range(cols)] for _ in range(rows)]
        data['received_bits'] = ""
        data['encoded_results'] = results
        write_data(data)
        logging.debug(f"Data after upload: {data}")
        return render_template('result.html', results=results)
    return render_template('upload.html')

@app.route('/api/get_encoded', methods=['GET'])
def get_encoded():
    data = read_data()
    logging.debug(f"Request from: {request.remote_addr}, Data: {data}")
    if not data['dna_read'] or not data['dna_reference']:
        return jsonify({"message": "No data available"}), 404
    return jsonify({
        "DNA Read": dna_to_binary(data['dna_read']),
        "DNA Reference": dna_to_binary(data['dna_reference'])
    })

@app.route('/api/check_data', methods=['GET'])
def check_data():
    data = read_data()
    logging.debug(f"Check data request from: {request.remote_addr}, Data: {data}")
    if data['dna_read'] and data['dna_reference']:
        return jsonify({"status": "ready", "dna_read": data['dna_read'], "dna_reference": data['dna_reference']})
    return jsonify({"status": "not_ready", "message": "No data available in file"})

@app.route('/matrix', methods=['GET', 'POST'])
def matrix():
    data = read_data()
    logging.debug(f"Request from: {request.remote_addr}, Data: {data}")
    if not data['dna_read'] or not data['dna_reference']:
        if request.method == 'GET':
            return render_template('matrix.html', message="No DNA data available. Please upload files first.")
        else:
            return jsonify({"message": "No data available. Please upload files first."}), 400

    dna_read = data['dna_read']
    dna_reference = data['dna_reference']
    rows = len(dna_reference)
    cols = len(dna_read)

    if not data.get('matrix') or len(data.get('matrix', [])) != rows or len(data.get('matrix', [[]])[0]) != cols:
        data['matrix'] = [[0 for _ in range(cols)] for _ in range(rows)]
        write_data(data)

    matrix = data['matrix']
    received_bits = data.get('received_bits', '')

    if request.method == 'POST':
        # Chuyển đổi dữ liệu POST thành dictionary thông thường
        if request.form:
            post_data = dict(request.form)
        else:
            post_data = request.get_json()

        if not post_data:
            return jsonify({"message": "No data provided"}), 400

        action = post_data.get('action', '')
        if action == 'update':
            bits = post_data.get('bits', '')
            if not bits:
                return jsonify({"message": "No bits provided"}), 400

            if received_bits:
                received_bits += ", " + bits
            else:
                received_bits = bits
            data['received_bits'] = received_bits

            if len(bits) >= 32 * (2 + 16):  # 32 for col, 32 for row, 16 values of 32 bits
                bit_idx = 0
                start_row_idx = int(bits[bit_idx:bit_idx + 32], 2)
                bit_idx += 32
                col_idx = int(bits[bit_idx:bit_idx + 32], 2)
                bit_idx += 32

                for i in range(16):
                    if bit_idx + 32 > len(bits):
                        break  # Avoid overflow
                    value = int(bits[bit_idx:bit_idx + 32], 2)
                    bit_idx += 32

                    current_row = start_row_idx + i
                    if current_row < rows and col_idx < cols:
                        matrix[current_row][col_idx] = value
                    else:
                        break  # Don't write outside matrix bounds

                data['matrix'] = matrix
                write_data(data)
                return render_template('matrix.html', matrix=matrix, dna_read=dna_read,
                                    dna_reference=dna_reference, bits=received_bits, enter_bits="")
            else:
                return jsonify({"message": "Invalid bit string length"}), 400


        elif action == 'reset':
            # Đặt toàn bộ giá trị trong ma trận về 0
            matrix = [[0 for _ in range(cols)] for _ in range(rows)]
            data['matrix'] = matrix
            write_data(data)
            return render_template('matrix.html', matrix=matrix, dna_read=dna_read, dna_reference=dna_reference,
                                 bits=received_bits, enter_bits="")

        elif action == 'align':
            if dna_read and dna_reference:
                sw_matrix, max_score, align_read, align_ref, align_result = smith_waterman(dna_read, dna_reference, matrix)
                return render_template('matrix.html', matrix=matrix, dna_read=dna_read, dna_reference=dna_reference,
                                     bits=received_bits, sw_matrix=sw_matrix, max_score=max_score,
                                     align_read=align_read, align_ref=align_ref, align_result=align_result)
            return render_template('matrix.html', matrix=matrix, dna_read=dna_read, dna_reference=dna_reference,
                                 bits=received_bits, message="DNA data missing")

        return jsonify({"message": "Invalid action"}), 400

    return render_template('matrix.html', matrix=matrix, dna_read=dna_read, dna_reference=dna_reference,
                         bits=received_bits, enter_bits="")

@app.route('/debug', methods=['GET'])
def debug():
    data = read_data()
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)