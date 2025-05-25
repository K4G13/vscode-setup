#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <memory>

// TODO LIST
// [ ] Task A
// [X] Task B
// [ ] Task C
// [ ] Task D

// Custom class definition
class Shape {
    protected:
        std::string name;
        double area;

    public:
        Shape(const std::string& n) : name(n), area(0.0) {}
        
        virtual ~Shape() {
            std::cout << "Destroying shape: " << name << std::endl;
        }
        
        virtual double calculateArea() const = 0;
        
        std::string getName() const {
            return name;
        }
        
        void setName(const std::string& n) {
            name = n;
        }
};

// Derived class
class Circle : public Shape {
private:
    double radius;
    static constexpr double PI = 3.14159265358979323846;

public:
    Circle(const std::string& n, double r) : Shape(n), radius(r) {}
    
    double calculateArea() const override {
        return PI * radius * radius;
    }
    
    double getRadius() const {
        return radius;
    }
};

// Template function
template<typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}

// Lambda expression
auto multiply = [](int a, int b) -> int {
    return a * b;
};

int main() {
    // Basic output
    std::cout << "C++ Syntax Highlighting Demo" << std::endl;
    
    // Variables and types
    int number = 42;
    double pi = 3.14159;
    bool isTrue = true;
    char letter = 'A';
    std::string text = "Hello, World!";
    
    // Control structures
    if (isTrue) {
        std::cout << "Condition is true!" << std::endl;
    } else {
        std::cout << "Condition is false!" << std::endl;
    }
    
    for (int i = 0; i < 5; ++i) {
        std::cout << "Loop iteration: " << i << std::endl;
    }
    
    int counter = 0;
    while (counter < 3) {
        std::cout << "While loop: " << counter << std::endl;
        ++counter;
    }
    
    // STL containers
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    
    // Range-based for loop
    for (const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // STL algorithms
    std::sort(numbers.begin(), numbers.end(), std::greater<int>());
    
    // Smart pointers
    std::unique_ptr<Circle> circle = std::make_unique<Circle>("My Circle", 5.0);
    std::cout << "Circle area: " << circle->calculateArea() << std::endl;
    
    // Exception handling
    try {
        if (number == 42) {
            throw std::runtime_error("The answer to everything!");
        }
    } catch (const std::exception& e) {
        std::cerr << "Exception caught: " << e.what() << std::endl;
    }
    
    return 0;
}
