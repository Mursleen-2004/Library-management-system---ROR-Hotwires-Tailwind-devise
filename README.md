# Library Management System

A full-stack **Ruby on Rails** application for managing a library's book catalog, members, and borrowing workflow — built with **Devise authentication**, **role-based authorization** (Admin / Member), **PostgreSQL**, and **Tailwind CSS**.

## Features

- **Authentication** — secure sign up / sign in / sign out via Devise (bcrypt password hashing)
- **Role-based access control** — Admins manage the catalog; Members browse & borrow
- **Full CRUD** — Books, Authors, and Categories
- **Borrowing workflow** — borrow / return books with due dates, automatic copy tracking, and overdue detection
- **Search & filtering** — search books by title/ISBN, filter by category or author
- **Admin dashboard** — live stats: total books, copies, users, active & overdue borrowings, most-borrowed titles
- **Pagination** — via Kaminari
- **Responsive UI** — Tailwind CSS, clean modern design
- **Data validations** — prevents over-borrowing, double-borrowing, and negative inventory

## Tech Stack

| Layer          | Technology              |
|----------------|--------------------------|
| Backend        | Ruby on Rails 7.1        |
| Database       | PostgreSQL               |
| Auth           | Devise                   |
| Styling        | Tailwind CSS             |
| Pagination     | Kaminari                 |
| Frontend       | Turbo + Stimulus (Hotwire) |

## Data Model

```
User (devise)  ─┬─< Borrowing >─┬─ Book ─┬─ belongs_to Author
 role: member/admin              status:  └─ belongs_to Category
                                  borrowed/returned/overdue
```