--[[
    This script performs various computational tasks, including:
    - Calculating factorials
    - Generating Fibonacci sequences
    - Matrix multiplication
    - String manipulation
    - Table operations
]]

-- Function to calculate factorial of a number
function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

-- Function to generate Fibonacci sequence up to n
function fibonacci(n)
    local a, b = 0, 1
    local sequence = {a}
    for i = 1, n - 1 do
        a, b = b, a + b
        table.insert(sequence, a)
    end
    return sequence
end

-- Function to perform matrix multiplication
function matrix_multiply(A, B)
    local C = {}
    for i = 1, #A do
        C[i] = {}
        for j = 1, #B[1] do
            C[i][j] = 0
            for k = 1, #B do
                C[i][j] = C[i][j] + A[i][k] * B[k][j]
            end
        end
    end
    return C
end

-- Function to reverse a string
function reverse_string(str)
    local reversed = ""
    for i = #str, 1, -1 do
        reversed = reversed .. str:sub(i, i)
    end
    return reversed
end

-- Function to deeply copy a table
function deep_copy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = deep_copy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- Heavy computational operations

-- Factorial of a large number
local fact = factorial(20)
print("Factorial of 20: ", fact)

-- Fibonacci sequence up to 30th element
local fib_seq = fibonacci(30)
print("Fibonacci sequence up to 30th element:")
for _, v in ipairs(fib_seq) do
    print(v)
end

-- Matrix multiplication of two large matrices
local A = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
}

local B = {
    {9, 8, 7},
    {6, 5, 4},
    {3, 2, 1}
}

local C = matrix_multiply(A, B)
print("Matrix multiplication result:")
for i = 1, #C do
    for j = 1, #C[i] do
        io.write(C[i][j], " ")
    end
    io.write("\n")
end

-- String reversal
local original_str = "The quick brown fox jumps over the lazy dog"
local reversed_str = reverse_string(original_str)
print("Original string: " .. original_str)
print("Reversed string: " .. reversed_str)

-- Deep copy of a table
local table_original = {1, {2, 3}, 4}
local table_copy = deep_copy(table_original)
table_copy[2][1] = 100
print("Original table: ")
for i, v in ipairs(table_original) do
    if type(v) == "table" then
        io.write("{")
        for _, t in ipairs(v) do
            io.write(t .. " ")
        end
        io.write("} ")
    else
        io.write(v .. " ")
    end
end
print("\nCopied table with modification: ")
for i, v in ipairs(table_copy) do
    if type(v) == "table" then
        io.write("{")
        for _, t in ipairs(v) do
            io.write(t .. " ")
        end
        io.write("} ")
    else
        io.write(v .. " ")
    end
end
print()
