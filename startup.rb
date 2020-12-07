require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if salaries.has_key?(title)
            return true
        else
            return false
        end
    end

    def >(startup2)
        if self.funding > startup2.funding
            return true
        else
            return false
        end  
    end

    def hire(emp, title)
        if valid_title?(title) == true
            emp1 = Employee.new(emp, title)
            @employees << emp1
        else
            raise StandardError.new "No title available at this company" 
        end
    end

    def size
        return employees.length
    end

    def pay_employee(employee)
        money_owed = @salaries[employee.title]
        if funding >= money_owed
            employee.pay(money_owed)
            @funding -= money_owed
        else
            raise "Not enough funding to pay employee"
        end
    end

    def payday
        @employees.each do |emp|
            pay_employee(emp)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |emp|
            sum += @salaries[emp.title]
        end
        sum / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup2)
        @funding += startup2.funding
        startup2.salaries.each do |title, salary|
            if !@salaries.has_key?(title)
                @salaries[title] = salary
            end
        end
        @employees += startup2.employees
        startup2.close
    end
end
