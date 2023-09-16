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

# Deploy with docker
1. Clone the github folder
    ```bash
    git clone https://github.com/art29/TransactionTracker-Rails.git
    ```
2. Make sure Docker & Docker Compose are installed properly and ports 3001 and 5433 are free
3. Copy the `.env.sample` file and create a `.env` file with your actual credentials
4. Run the docker compose file (you may need to login to github to pull the image)
    ```bash
   # Optional (only if it doesn't work without it, if you need it, you'll need a Github Personal Access Token)
   echo $GITHUB_PERSONAL_ACCESS_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin
   docker compose pull
   docker compose up -d
    ```
5. Install a reverse proxy (Apache, Nginx, Caddy etc.) and open port 3001
6. Everything should now be working!

## Contribute
Feel free to contribute by making PRs or opening issues if you find any bugs!
