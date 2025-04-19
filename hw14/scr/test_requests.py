import requests

BASE_URL = "http://localhost:5000/students"

def log_result(message, file_path='results.txt'):
    """Logs results to console and file"""
    print(message)
    with open(file_path, 'a', encoding='utf-8') as f:
        f.write(message + '\n')

def test_student_api():
    open('results.txt', 'w').close()

    log_result("\n1. Fetching all students:")
    response = requests.get(BASE_URL)
    log_result(f"Status: {response.status_code}")
    log_result(f"Students: {response.json()}")

    # Creating three students with new English names
    students = [
        {"name": "Ethan", "surname": "Carter", "age": "22"},
        {"name": "Olivia", "surname": "Miller", "age": "24"},
        {"name": "Benjamin", "surname": "Harris", "age": "26"}
    ]

    created_students = []
    log_result("\n2. Adding three students:")
    for student in students:
        response = requests.post(BASE_URL, json=student)
        log_result(f"Created student: {response.json()}")
        created_students.append(response.json())

    # Updating the second student (PATCH)
    second_student_id = created_students[1]['id']
    log_result(f"\n3. Updating Olivia's age (ID: {second_student_id}):")
    response = requests.patch(f"{BASE_URL}/{second_student_id}", json={"age": "25"})
    log_result(f"Updated student: {response.json()}")

    # Deleting the first student
    first_student_id = created_students[0]['id']
    log_result(f"\n4. Deleting Ethan (ID: {first_student_id}):")
    response = requests.delete(f"{BASE_URL}/{first_student_id}")
    log_result(f"Delete result: {response.json()}")

    # Final list of students
    log_result("\n5. Final student list:")
    response = requests.get(BASE_URL)
    log_result(f"Students: {response.json()}")

if __name__ == "__main__":
    test_student_api()
