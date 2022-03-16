# Adopt, Don't Shop!
This RESTful application was built using Rails to meet the requirements of the [Adopt, Don't Shop](https://github.com/turingschool-examples/adopt_dont_shop) solo project for Module 2 of the Back End Engineering program at [Turing School of Software and Software and Design](https://turing.edu/). The project was submitted on 2/16/2022.

[VIEW THE DEPLOYED APPLICATION HERE](https://agile-journey-71634.herokuapp.com/)

## Table of Contents
* [Purpose and Functionality](#purpose-and-functionality)
* [Database Structure and Interface](#database-structure-and-interface)
* [User Capabilities](#user-capabilities)
* [Test Driven Development](#test-driven-development)
* [Additional Project Notes](#additional-project-notes)

## Purpose and Functionality
The application is built to meet the needs of a hypothetical pet adoption platform, wherin users can search for pets, fill out applications to adopt a pet, and admins can review and approve or reject applications. The learning goals of the project were given as follows:
* Build out CRUD functionality for a many to many relationship
* Use ActiveRecord to write queries that join multiple tables of data together
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Validate models and handle sad paths for invalid data input
* Use flash messages to give feedback to the user
* Use partials in views
* Use within blocks in tests
* Track user stories using GitHub Projects
* Deploy an application to Heroku
* NOTE: While the Shelter, Veterinarian and Veterinary Office resources were included in the original repository, this project focused exclusively on building features around Pet and Application data.

## Database Structure and Interface
<img width="800" alt="database-structure" src="https://user-images.githubusercontent.com/91342410/154379463-ab2820b8-0c67-41ce-a746-6995ed37913d.png">
The involved resources consist of one one:many and one many:many relationship. PostgreSQL was the chosen database manager, and ActiveRecord was used for querying within Rails.

## User Capabilities
* Homepage
   * Follow header navigation links to browse Pets, Shelters, Veterinarians, and Veterinary Offices.
<img width="300" alt="homepage" src="https://user-images.githubusercontent.com/91342410/158635319-89b94735-99cb-4f98-9ecb-75f0194710e1.png">
* Pets
   * View the Index Page to see a list of Pets, with Age, Breed and Shelter info, along with Adoptable status.
   * Search for Pets by Name, partial matches accepted.
   * Click links to edit or delete each Pet from the Index.
   * Click a button to start a new Application.
* Filling Out Applications
   * Form collects Name, Street Address, City, State and Zip Code attributes from an applicant:
<img width="300" alt="new-application-form" src="https://user-images.githubusercontent.com/91342410/158637371-8b30f602-3b64-4c99-9d26-d3c0d3bc6395.png">
   * After entering the data, the user is taken to a Show page that shows the Application info, with a Status of "In Progress".
   * There is also a section where the user can search for Pets and add them to the Application.
   * After one or more Pets have been added, the user is given the ability to complete the Application by filling out a description of why they would make a good pet owner.
<img width="551" alt="complete-application" src="https://user-images.githubusercontent.com/91342410/158638222-2e52c666-8e48-4cb8-b877-f4d2fe09e377.png">
   * Once the Application is submitted, its status changes to "Pending".
* Approving Applications
   * The Admin Application [Show page](/admin/applications/54) shows all the attributes about each Application. There are also buttons to Approve or Reject the Application.
   * Each Pet can be individually approved or rejected for the Application. 
   * If a Pet is Approved, they will be removed from other user search results.
   * If any pet is Rejected for an Application, the entire Application has a Rejected Status.
<img width="298" alt="image" src="https://user-images.githubusercontent.com/91342410/158642319-7c1d4221-dd72-4d10-8ecd-483d6c1a0cf1.png">

## Test Driven Development
The project consists of 108 feature tests and 66 model tests, all passing with 100% coverage across the reop. Tests were written to the specifications of the user stories and used to direct the code production. To support thorough testing of features and models, several gems were incoroporated, including `rspec`, `capybara`, and `launchy`. To test for correct ordering and placement on views, Capybara's `within` blocks were used in conjunction with HTML ID tags.

## Additional Project Notes
* I made it through the `Completed Applications` user stories. Time kept me from completing the extensions, which could be useful for future exploration.
* I was having an issue where Heroku was changing a button html verb from `patch` to `post` (on the "Approve" and "Reject" buttons in 'app/views/applications/admin_show.html.erb'. It ran fine on localhost:3000 but was not performing the correct action on the deployed app. I added two additional `post` routes that are otherwise identical to the `patch` routes for these buttons, and it now works.
* Two partials were employed:
   * in 'app/views/applications', '\_details.html.erb' serves up basic application attributes to the user and admin show pages.
   * in 'app/views/pets', '\_form.html.erb' collects user data on the `new` and `edit` pages.
* I tried to be more conscious of how my tests are organized. I alternated between using `before :each` blocks and putting code into each individual test, just to experience both approaches.
* Several edge cases I identified that satisfy the User Story #9, but could still be problematic:
   * When a pet is on more than one application, and gets approved on one application, the admin must click `reject` for that pet on the other application. However, if this application is approved for another pet, the entire application will be rejected.
   * If there are multiple admins simultaneously approving or rejecting pets for applications, it is possible that a pet could be approved on more than one approved applications. For example, if two admins approve the pet on two different applications, and those applications have multiple pets, so that the application itself does not get marked "Approved" (when ALL pets on the app are approved/rejected) before the pet is also approved for the other application.
