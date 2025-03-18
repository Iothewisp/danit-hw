class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = list(letters)

    def print(self):
        print(" ".join(self.letters))

    def letters_num(self):
        return len(self.letters)


class EngAlphabet(Alphabet):
    _letters_num = 26  # Количество букв в английском алфавите

    def __init__(self):
        super().__init__('En', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')

    def is_en_letter(self, letter):
        return letter.upper() in self.letters

    def letters_num(self):
        return self._letters_num

    @staticmethod
    def example():
        return "The quick brown fox jumps over the lazy dog."


# Тестирование
if __name__ == "__main__":
    eng_alphabet = EngAlphabet()
    
    # Вывод букв алфавита
    eng_alphabet.print()
    
    # Количество букв в алфавите
    print("Number of letters:", eng_alphabet.letters_num())
    
    # Запрос буквы у пользователя
    while True:
        user_input = input("Enter a letter (or 'exit' to quit): ")
        if user_input.lower() == 'exit':
            break
        elif len(user_input) == 1:
            if eng_alphabet.is_en_letter(user_input):
                print("Yes, we have this letter.")
            else:
                print("No, there is no such letter in the English alphabet.")
        else:
            print("Please enter only one letter.")
    
    # Вывод примера текста
    print("Example text:", EngAlphabet.example())
