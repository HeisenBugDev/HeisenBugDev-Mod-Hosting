
This is a file generated from the db:populate rake task. It will provide useful information about what it did such as login creds for the admin user.

Database was reset before populating.

Admin User
==========

An admin/owner user was created. This user has access to **everything** on the site. The following is the `.to_json` output of the user and login creds.

## Login info

    Name: admin
    email: admin@example.com
    password: adminpassword

## #to_json output for User


    {
      "id": 1,
      "email": "admin@example.com",
      "created_at": "2014-06-30T22:05:54.605Z",
      "updated_at": "2014-06-30T22:05:54.605Z",
      "provider": null,
      "uid": null,
      "name": "admin",
      "authentication_token": "jFoajU7T4wJAnZ5xML_9"
    }


Normal Users
============

99 normal users were created with random names. All the passwords are: foobarbaz. One of the user's #to_json will be printed below.

## #to_json output for User


    {
      "id": 100,
      "email": "example-99@example.com",
      "created_at": "2014-06-30T22:06:00.249Z",
      "updated_at": "2014-06-30T22:06:00.249Z",
      "provider": null,
      "uid": null,
      "name": "Maegan98",
      "authentication_token": "HdUS9YzcKdzyvwuApPXf"
    }


Projects
========

99 projects were created with random names. Their icons are from the asset download. The following is the `.to_json` output of one of the projects.

## #to_json output for Project


    {
      "id": 99,
      "name": "Gorgeous Steel Hat",
      "description": "Welcome to my amazing mod, Gorgeous Steel Hat. This mod will save your life. I am not liable for any life saving not done. It is your fault because you clearly did not play this mod.",
      "created_at": "2014-06-30T22:06:01.238Z",
      "updated_at": "2014-06-30T22:06:01.238Z",
      "code_repo": "HeisenBugDev/ExampleRepo",
      "subtitle": "Yet another awesome mod",
      "icon": {
        "url": "/uploads/project/icon/99/98.png"
      }
    }


