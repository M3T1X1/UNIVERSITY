import csv
from typing import Callable

import file


class Employee:

    def __init__(self, name, salary,position):
        self.name = name
        self.salary = salary
        self.position = position

        pracownik01 = Employee("Andrzej",120000,"programer")

    def to_csv_string(self):
        return f"{self.name},{self.salary},{self.position}"

    @staticmethod
    def to_file(file_handle,employee:list['Employee']):
        for e in employee:
            file.write(e.to_csv_string())

    @staticmethod
    def from_file(file_handle):
        try:
            file_handle.open("r")
        except FileNotFoundError:
            print("File not found")

        employees = []
        reader = csv.reader(file_handle)
        for row in reader:
            if row:
                name, salary, position = row
                employees.append(Employee(name, salary, position))
        return employees
