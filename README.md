# Transactions Rails

An Open-Source transaction tracker. This can be used to track your spending per categories, month by month or year by year easily. It also gives you access to charts to see how your spending habits look.

This part is only the back-end part. To see the Angular front-end [click here](https://github.com/art29/TransactionTracker-Angular).

## Tech
- Rails 7 with Postgres
- Devise Token Auth for Authentication
- Capistrano for deployment

## Run for Dev
1. Make sure Ruby & Postgres is installed
2. Install packages with `bundle install`
3. Setup the DB with `rails db:create` and `rails db:migrate` (While making sure the credentials match your own DB settings)
4. Launch App with `rails s`
5. The API is available at [http://localhost:3000/api/v1](http://localhost:3000/api/v1)

## Contribute
Feel free to contribute by making PRs or opening issues if you find any bugs!
