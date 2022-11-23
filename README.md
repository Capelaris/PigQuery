# PigQuery
![Build](https://img.shields.io/appveyor/build/Capelaris/PigQuery?style=flat-square)
![License](https://img.shields.io/packagist/l/Capelaris/PigQuery?style=flat-square)
![Repo Size](https://img.shields.io/github/repo-size/Capelaris/PigQuery?style=flat-square)
![Forks](https://img.shields.io/github/forks/Capelaris/PigQuery?style=flat-square)
![Open pull requests](https://img.shields.io/github/Capelaris/PigQuery?style=flat-square)

<p align="center">
  <img src="/images/logo.svg" alt="PigQuery Logo" width="350px">
</p>

> Tool developed for the standardization and good formation of Querys.

## 🧱 Already developed and future updates

### **Columns**

- **[ X ]** Primary Key
- **[ X ]** Base Column
- **[ X ]** SmallInt
- **[ X ]** Integer
- **[ X ]** BigInt
- **[ X ]** Decimal
- **[ X ]** Numeric
- **[ X ]** ctFloat
- **[ X ]** Double Precision
- **[ X ]** Date
- **[ X ]** Time
- **[ X ]** TimeStamp
- **[ X ]** Char
- **[ X ]** Varchar
- **[ X ]** Blob Binary
- **[ X ]** Blob Text

### **Tables**

- **[ X ]** Base Table
- **[ X ]** Table Alias

### **Pairs**

- **[ X ]** Base Pair

### **Joins**

- **[ X ]** Base Join
- **[ X ]** Inner Join
- **[ X ]** Left Join
- **[ X ]** Right Join
- **[ X ]** Outer Join

### **Conditions**

- **[ X ]** Base Condition
- **[ X ]** And, Or, In
- **[ X ]** And Nor, Or Not, Not In

### **Queries**

- **[ X ]** Base Query
- **[ X ]** Select Query
- **[ X ]** Delete Query
- **[ X ]** Insert Query
- **[ X ]** Update Query

## ⚜️ Boss Instalation

To use the library in your project, just add the fonts from the `src` folder in your project, or by installing the Boss tool.

- To install the boss, just enter this repository and follow the step by step [https://github.com/HashLoad/boss](https://github.com/HashLoad/boss).
- After installing Boss, run the following command

```sh
boss install Capelaris/PigQuery
```

## ☕ Using PigQuery

To use this project, you must call the ```PigQuery``` unit:

```delphi
uses PigQuery;
```

### Select Query

```delphi
TSelectQuery.Create('Table1')
  .Where('column1', QuotedStr('test'))
  .GetSQL(['column1', 'column2']);
```

Result

```sql
select a.column1,
       a.column2
from Table1 a
where column1 = 'test'
```

> For more details and other examples, [visit the Wiki](https://github.com/Capelaris/PigQuery/wiki/Select-Query)

### Insert Query

```delphi
TInsertQuery.Create('Table1')
  .SetPair('column1', 'value 1')
  .SetPair('column2', 'value 2')
  .GetSQL;
```

Result

```sql
insert into Table1 (column1,
                    column2)
values ('value 1',
        'value 2')
```

> For more details and other examples, [visit the Wiki](https://github.com/Capelaris/PigQuery/wiki/Insert-Query)

### Update Query

```delphi
TUpdateQuery.Create('Table1')
  .SetPair('column1', 'value 1')
  .SetPair('column2', 'value 2')
  .Where('column1', QuotedStr('test'))
  .GetSQL;
```

Result

```sql
update Table1 a
set a.column1 = 'value 1',
    a.column2 = 'value 2'
where column1 = 'test'
```

> For more details and other examples, [visit the Wiki](https://github.com/Capelaris/PigQuery/wiki/Update-Query)

### Delete Query

```delphi
TDeleteQuery.Create('Table1')
  .Where('column1', QuotedStr('test'))
  .GetSQL;
```

Result

```sql
delete from Table1 a
where column1 = 'test'
```

> For more details and other examples, [visit the Wiki](https://github.com/Capelaris/PigQuery/wiki/Delete-Query)

## 🤝 Collaborators

We thank the following people who contributed to this project:

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/foreveralones">
        <img src="https://avatars.githubusercontent.com/u/28955078" width="100px;" alt="Weslley Capelari on GitHub"/><br>
        <sub>
          <b>Weslley Capelari</b>
        </sub>
      </a>
    </td>
    </td>
  </tr>
</table>


## 😄 Be a contributor

Want to be part of this project? [Click Here](CONTRIBUTING.md) and read how to contribute.

## 📝 License

This project is under license. See [License file](LICENSE.md)  for more details.

[⬆ Back to Top](#PigQuery)
