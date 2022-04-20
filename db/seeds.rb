# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

c1 = Customer.create(first_name: "Test", last_name: "Person1", email: "test@person1.com", address: "12345 Something Road")
c2 = Customer.create(first_name: "Test", last_name: "Person2", email: "test@person2.com", address: "12345 Something Road")
c3 = Customer.create(first_name: "Test", last_name: "Person2", email: "test@person3.com", address: "12345 Something Road")

t1 = Tea.create(title: "Earl Grey", description: "Black Tea", temperature: 110, brew_time: 3)
t2 = Tea.create(title: "Green", description: "Green Tea", temperature: 100, brew_time: 5)
t3 = Tea.create(title: "Mint", description: "Mint Tea", temperature: 103, brew_time: 8)
t4 = Tea.create(title: "Matcha", description: "Matcha Tea", temperature: 107, brew_time: 9)
t5 = Tea.create(title: "Oolong", description: "Oolong Tea", temperature: 95, brew_time: 2)
t6 = Tea.create(title: "Ginger", description: "Ginger Tea", temperature: 109, brew_time: 15)
t7 = Tea.create(title: "Chamomile", description: "Chamomile Tea", temperature: 99, brew_time: 6)

Subscription.create(title: t1.title, price: 10.00, status: 0, frequency: 1, tea_id: t1.id, customer_id: c1.id)
Subscription.create(title: t2.title, price: 10.00, status: 0, frequency: 1, tea_id: t2.id, customer_id: c1.id)
Subscription.create(title: t3.title, price: 10.00, status: 0, frequency: 1, tea_id: t3.id, customer_id: c1.id)

Subscription.create(title: t2.title, price: 10.00, status: 0, frequency: 1, tea_id: t2.id, customer_id: c2.id)
Subscription.create(title: t3.title, price: 10.00, status: 0, frequency: 1, tea_id: t3.id, customer_id: c2.id)

Subscription.create(title: t2.title, price: 10.00, status: 1, frequency: 1, tea_id: t2.id, customer_id: c1.id)
