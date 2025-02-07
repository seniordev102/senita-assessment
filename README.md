# Sentia Coding Test - Ruby on Rails Application

## Overview

This Ruby on Rails application allows users to upload a CSV file containing data about people, locations, and affiliations. The application imports the data into a database and provides functionality to view, paginate, search, and sort the imported data.

The application is designed based on the user stories and requirements outlined in the coding test, ensuring that data integrity and validation are maintained throughout the process.

## How to Setup

### Prerequisites

- Ruby (version 3.2.2 or later)
- Rails (version 7 or later)
- PostgreSQL (or your preferred database)
- Bundler

### Steps to Setup

1. **Clone the Repository**

   ```bash
   git clone git@github.com:seniordev102/senita-assessment.git
   cd senita-assessment
   ```

2. **Install Dependencies** Make sure you have Bundler installed, then run:
   ```bash
   bundle install
   ```
3. **Set Up Database** Create and migrate the database:
   ```bash
   rake db:create
   rake db:migrate
   CSV_FILE_PATH=tmp/test_data.csv rake csv:import
   ```
4. **Run test** Run request test to make sure it works as expected:
   ```bash
   bundle exec rspec spec/requests/api/v1/people_spec.rb
   ```
5. **Run Rails Server**
   ```bash
   rails s -p 3011
   ```
6. **Frontend setup** Open another terminal and set Frontend env variable:
   ```bash
   cd frontend
   yarn install
   cp .env.example .env
   ```
7. **Run Application** Start the Rails & FE dev server:
   and open another terminal
   ```bash
   npm start
   ```

### What Could Be Improved

- User Interface: Enhance the UI for a better user experience, possibly using third party modules.
- Performance Optimization: If the dataset grows large, consider implementing background processing for the CSV import using Sidekiq.
- Advanced Search and Filtering: Provide more advanced search capabilities, allowing users to combine multiple filters.
- Testing: Expand test coverage to include feature tests and edge cases for CSV imports.
- Documentation: Improve documentation, especially for API endpoints using swagger, to assist future developers or users.
- Refactoring: Implement design patterns and solid architecture to maintain scalability as project grows
