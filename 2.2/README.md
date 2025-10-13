# Name Mangler
Refactor applying *Clean Code* principles from chapters 3 and 4.

## Code Overview
This refactored version removed global vars, breaks large multifaceted functions into smaller, intentional ones, as well as replacing unnecessary comments with clear naming.

## Reflection Questions

### **1. What is the DRY Principle?**
The DRY Principle stands for *Don't Repeat Yourself.*
It means that every piece of logic or data should exist only one place in the codebase, and if you have to update something in multiple spots you are violating DRY.

### **2. Should each function on contain one statement? Why or why not?**
No, functions should *do one thing* but that thing can take multiple statements as long as all lines of code are contributing to a single purpose at one level of abstraction, the function is clean. 

### **3. Why is it useful to extract a function even if its only called once?**
Even if a function is only used once, it gives the block of code a name that clearly expresses the intent of the function. It also helps to isolate the logic in future testing, so if there is any issue it is far easier pointed out, while also helping the code flow better.