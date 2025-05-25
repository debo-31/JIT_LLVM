def calculate_sum(n):
    result = 0
    for i in range(n):
        result += i
    return result

def main():
    n = 10
    print(f"Sum of numbers from 0 to {n-1} is: {calculate_sum(n)}")

if __name__ == "__main__":
    main() 