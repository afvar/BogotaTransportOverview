<h1>BogotaTransportOverview</h1>

<p>This project contains information and analysis of transportation behavior in Bogota city.<br>

To see the results you must do the following steps:</p>

<ol>
  <li>You must have installed the following programs in your machine:
    <ul>
      <li>SQL Server (Express) v14.0.1000.169 or higher.</li>
      <li>SQL Server Management Studio v14.0.17289.0 or higher.</li>
      <li>R v3.5.2 or higher.</li>
      <li>RStudio v1.1.463 or higher.</li>
    </ul>
  </li>
  <br>  
  <li>Create an SQlServer instance in your machine:
    <ol>
      <li>Open windows command prompt (cmd).</li>
      <li>Wrtite "sqllocaldb create BogTrPoll".</li>
      <li>Close the command prompt</li>
    </ol>
  </li>
  <br>
  <li>Download all the files of this repository in your machine.</li>
  <br>
  <li>Open the file in "...\BogotaTransportOverview\BogTrPoll_DataBase\Script\SQLQueryDB.sql" and do the following steps:
    <ul>
      <li>Log to the server "(LocalDb)\BogTrPoll" (Server Name: (LocalDb)\BogTrPoll)</li>
      <li>Select "Windows Authentication"</li>
      <li>Click in Connect</li>
      <li>Change the directory in line 23 by the project directory of your machine.</li>
      <li>Select all the query and execute it with F5. Then you have created the database in your repository.</li>
      <li>Close SQL Management Studio</li>
    </ul>
  </li>
  <li>Execute the script in "Connection to DB.R" to do the backend processes</li>
<ol>
