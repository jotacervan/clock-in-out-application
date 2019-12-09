# Clock In Out Application

Clock In Out is an application that keep records of your work time, and makes easy for you to track your weekly hours balance.
**demo: https://clock-registry-app.herokuapp.com/**

### Tech

Clock In Out uses a number of open source projects to work properly:

* [Ruby on Rails]
* [ReactJS]
* [Material Ui]
* [Styled Components]
* [Sweet Alert]

And of course Clock In Out App itself is open source with a public repository on GitHub.

### Development

Want to contribute? Great!
The application requires Ruby on Rails, NodeJs and PostgreSQL to run.

Install the dependencies.

```sh
$ cd clock-in-out-application
$ bundle install
$ yarn install
```

Create and migrate database and start the server.

```sh
$ rails db:create db:migrate
$ rails s
```

*Obs: Make sure that your postgresql database is running, if you don't have it you can run a docker container with it running the commands below*

```sh
$ docker run -d --name database -p 5432:5432 postgres
```

### Todos

 - Write MORE Tests.
 - Extend user Role.
 - Create calendar visualization at clock events page.
 - Create admin reports.
 - Create script to download sheet.
 - Dockerize the application.
 - Implement Redis and Sidekiq to proccess reports.
 - Add real time and email notifications.

License
----

MIT


**Free Software, Hell Yeah!**



   [Ruby on Rails]: <https://rubyonrails.org/>
   [ReactJs]: <https://reactjs.org/>
   [Material Ui]: <https://material-ui.com/>
   [Styled Components]: <https://www.styled-components.com/>
   [Sweet Alert]: <https://sweetalert2.github.io/>
   
