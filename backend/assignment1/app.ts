import Calculator from "./calculator";

const calculator = new Calculator();

console.log(calculator.add(100, 200));
console.log(calculator.subtract(250, 45.5));
console.log(calculator.multiply(5, 25));
console.log(calculator.divide(100, 0));
console.log(calculator.modulus(5, 2));
console.log(calculator.power(10.5, 2));
console.log(calculator.percentage(20, 100))