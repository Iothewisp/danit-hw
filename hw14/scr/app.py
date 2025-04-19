from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)
CSV_FILE = "students.csv"

# 🟢 Создает CSV-файл, если его еще нет
def create_csv_if_missing():
    if not os.path.exists(CSV_FILE):
        with open(CSV_FILE, mode="w", newline="", encoding="utf-8") as file:
            writer = csv.writer(file)
            writer.writerow(["id", "name", "surname", "age"])

# 🟢 Читает список всех студентов
def get_all_students():
    create_csv_if_missing()
    with open(CSV_FILE, newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)

# 🟢 Записывает обновленный список студентов в файл
def save_students_to_file(students):
    create_csv_if_missing()
    with open(CSV_FILE, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['id', 'name', 'surname', 'age']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(students)

# 🟢 Генерирует новый ID
def get_next_student_id(students):
    if not students:
        return '1'
    return str(max(int(student['id']) for student in students) + 1)

@app.route("/")
def home():
    return "Welcome to the Student API!"

# 🟢 Получает список всех студентов
@app.route("/students", methods=["GET"])
def fetch_students():
    return jsonify(get_all_students())

# 🟢 Получает студента по ID
@app.route("/students/<id>", methods=["GET"])
def fetch_student_by_id(id):
    students = get_all_students()
    student = next((s for s in students if s["id"] == id), None)
    return jsonify(student) if student else ("Student not found", 404)

# 🟢 Добавляет нового студента
@app.route("/students", methods=["POST"])
def add_new_student():
    students = get_all_students()
    data = request.json
    #Debug
    print("DEBUG: Полученные данные:", data)

    if not all(key in data for key in ["name", "surname", "age"]):
        return jsonify({"error": "Missing name, surname, or age"}), 400

    new_id = get_next_student_id(students)

    new_student = {
        "id": new_id,
        "name": data["name"],
        "surname": data["surname"],
        "age": data["age"]
    }

    students.append(new_student)
    save_students_to_file(students)
    return jsonify(new_student), 201

# 🟢 Полностью обновляет студента (PUT)
@app.route("/students/<id>", methods=["PUT"])
def update_student(id):
    students = get_all_students()
    data = request.json

    for student in students:
        if student["id"] == id:
            student.update({
                "name": data.get("name", student["name"]),
                "surname": data.get("surname", student["surname"]),
                "age": data.get("age", student["age"])
            })
            save_students_to_file(students)
            return jsonify(student)

    return jsonify({"error": "Student not found"}), 404

# 🟢 Частично обновляет студента (PATCH)
@app.route("/students/<id>", methods=["PATCH"])
def partially_update_student(id):
    students = get_all_students()
    data = request.json

    for student in students:
        if student["id"] == id:
            for key, value in data.items():
                if value is not None:
                    student[key] = value
            save_students_to_file(students)
            return jsonify(student)

    return jsonify({"error": "Student not found"}), 404

# 🟢 Удаляет студента по ID
@app.route("/students/<id>", methods=["DELETE"])
def remove_student(id):
    students = get_all_students()
    
    student_to_delete = next((s for s in students if s["id"] == id), None)
    
    if not student_to_delete:
        return jsonify({"error": "Student not found"}), 404

    students = [s for s in students if s["id"] != id]
    save_students_to_file(students)
    return jsonify({"message": "Student deleted"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
