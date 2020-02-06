const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const passport = require('passport');
const cookieSession = require('cookie-session');
const keys = require('./app/config/keys');

const app = express();
const http = require('http').createServer(app);
const https = require('https');

const fs = require('fs');
const privateKey  = fs.readFileSync('ssl/server.key', 'utf8');
const certificate = fs.readFileSync('ssl/server.crt', 'utf8');

const credentials = {key: privateKey, cert: certificate};
const httpsServer = https.createServer(credentials, app);
const io = require('socket.io')(httpsServer);

const port = 3000;

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({ extended: true}));
app.use(cors());

// Auth 
app.use(cookieSession({
    maxAge: 24 * 60 * 60 * 1000,
    keys: [keys.session.cookieKey]
}));

app.use(passport.initialize());
app.use(passport.session());
const passportSetup = require('./app/config/passport-setup');
const authRoutes = require('./app/routes/auth-routes');
const profileRoutes = require('./app/routes/profile-routes');
app.use('/auth', authRoutes);
app.use('/profile', profileRoutes);

app.get("/", (req, res) => {
    res.json({ message: "Hello world!"});
});

const sql = require("./app/models/db");

io.on('connection', function(socket) {
    console.log('a user connected');
    socket.on('search', (data) => {
        console.log(data);
        sql.query(`SELECT * FROM courses WHERE name LIKE '${data}%'`, (err, res) => {
            if(err)
                return
            io.emit('search-data', res);
        });
    })
})

require("./app/routes/student.routes.js")(app);
require("./app/routes/course.routes.js")(app);
require("./app/routes/student-course.routes.js")(app);
require("./app/routes/module.routes.js")(app);

/*http.listen(port, () => {
    console.log("http Server is running on port: " + port);
})*/
httpsServer.listen(port, () => {
    console.log("https Server is running on port: " + port);
})