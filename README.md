# UpdateMailer
UpdateMailer is a email application to easily create and send engaging emails towards set audiences. It is build in Ruby on Rails

**Features Include:**
- Adding pre-defined email templates
- Creating and managing email distribution groups
- WYSIWYG Editor for email content
- Email tracking and statistics

## How to get started
### Prerequisites
- Ruby v2.3.0
- Rails v4.2.5.1
- PostgreSQL

### Setting up the project
##### Cloning the project
```bash
git clone https://github.com/Meo404/updatemailer.git
cd updatemailer
bundle install
```

##### Set up database and seed data
Setting up seed data requires valid reddit credentials.
```bash
rake db:create db:migrate db:seed
```

##### Run the application
```bash
rails s
```

##### Adding an admin account
Open a rails console and type:
```bash
CreateAdminService.call
```

##### Adding seed data
Open a rails console and type:
```bash
MockDataService.create_data
```