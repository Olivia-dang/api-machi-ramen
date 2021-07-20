# README

ruby version '3.0.1'

## Install dependencies
```
bundle install
```

## master.key and credentials

Because it's not good practice to share secrets. This repo is missing a master.key file, therefore it is unable to unencrypt credentials.yml.enc. For knock to run correctly it requires a secret_key_base As such you may encounter an error when trying to generate a jwt if you haven't dealt with this. The best course of action is to delete credentials.yml.enc and then

- generate a secret key in terminal
```
rake secret
```
- create and open the credentials:
```
EDITOR="code --wait" rails credentials:edit
```
- Replace `<secret-key>` with the secret key created above
```
devise:
  jwt_secret_key: <secret-key>
```
(two space before jwt_secret_key: and one space after)

In your ternimal, this will generate a new master.key and credentials.yml.enc. Add this line to the end of the credentials file. 

## Set up database PostgreSQL
```
rails db:create
rails db:migrate
rails db:seed
```
