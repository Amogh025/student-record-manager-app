# Student Record Manager

A desktop CRUD app built with Java Swing, JDBC, and MySQL. Add, search by ID, update, delete, view, and filter student records in a sortable table.

## Requirements
- JDK 17 or newer (`java` and `javac` on PATH)
- MySQL Server 8.0 or newer
- Internet access the first time you run the app (to fetch MySQL Connector/J)

## Database
In MySQL Workbench, open and execute `database/schema.sql`. It creates the `student_records` database and `students` table. Default connection: `localhost:3306`, user `root`, blank password.

On Windows, `run.bat` prompts for the MySQL password with hidden input if `DB_PASSWORD` is not set. The default username is `root`; press Enter at the prompt for an empty password. To configure another connection, set `DB_URL`, `DB_USER`, and `DB_PASSWORD`. For example in PowerShell:

```powershell
$env:DB_USER = "root"
$env:DB_PASSWORD = "your-password"
.\run.bat
```

macOS/Linux:

```sh
export DB_USER=root
export DB_PASSWORD='your-password'
chmod +x run.sh
./run.sh
```

The default JDBC URL is `jdbc:mysql://localhost:3306/student_records?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true`.

## Run
- Windows: double-click `run.bat` or launch it in PowerShell.
- macOS/Linux: run `./run.sh` (make executable with `chmod +x run.sh` once).

