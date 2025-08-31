

#  Send Money App

A simple Flutter application following **Clean Architecture** and **BLoC/Cubit** for state management.  
The app simulates sending money, viewing wallet balance, and checking transaction history.

---

##  Features
-  Login (mock API using `mockapi.io`)
-  Wallet Dashboard (view balance & refresh user info)
-  Send Money (transfer money to another user)
-  Transaction History (list of past transactions)
-  Unit tests included for Cubits & UseCases **(not done) ( SORRY HUHU )**

---

##  Project Structure (Clean Architecture)


# Send Money App - Login Instructions

This project is a mock Send Money application using Flutter. The user data is provided
via [MockAPI.io](https://mockapi.io) and is subject to change every time a transaction occurs (e.g.,
when sending money).

## Sample Users

Here are some sample accounts you can use to login:
| Username           | Password        | Name     | Balance |
|--------------------|-----------------|----------|---------|
| Britney.Jast       | t7M7VKXRnuZjghU | Keenan   | 29      |
| Giovani_Hartmann75 | rLF2WtkdWIzLJVq | Deion    | 32      |
| Ivy_Hauck          | CLdrQ2HhRHLK7_L | Garth    | 27      |
| Palma.Adams4       | WmVTyiADyYFNgA6 | Vallie   | 95      |
| Quinton82          | 9Up9i9qYZedph_X | Cristian | 96      |
| Johnnie_Kunde54    | 0dEXEjXceYcFU_C | Elinore  | 13      |
| Meggie.Rice        | SsTRw2Fx_G56KaV | Emanuel  | 20      |
| Noemy38            | vqR5Hxy5yiHzX_2 | Gertrude | 67      |
| Tomas87            | imvGdBv0ogdNj9w | Noelia   | 50      |
| Leonor.Schamberger | 4ymGmqphvBsAyB8 | Marian   | 53      |

> **Note:** Balances and transactions will change every time you perform a "send money" operation.
> This is because the backend data is dynamic and provided by MockAPI.io.

## How to Login

1. Open the app.
2. On the login screen, enter a valid **username** and **password** from the table above.
3. Tap **Login**.
4. If credentials are correct, you will be redirected to the dashboard showing your account balance
   and recent transactions.
5. You can perform transactions, which will update the balance and transaction history.

##

## Notes

- This is a mock application for testing purposes only.
- All user data is randomly generated and may reset or change if you restart the backend on
  MockAPI.io.
- Always use valid credentials from the table; invalid login attempts will result in an error
  message.
- **Unit tests are not done ( SORRY HUHU )**



### Class Diagram AND Sequence Diagram
```mermaid
classDiagram
    class User {
      -String id
      -String name
      -double balance
      +deposit(amount)
      +withdraw(amount)
    }

    class Transaction {
      -String id
      -String senderId
      -String receiverId
      -double amount
      -DateTime date
    }

    User --> Transaction



