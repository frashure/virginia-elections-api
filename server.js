const express = require('express');
const app = express();
const bodyparser = require('body-parser');
const env = require('dotenv').config();
const helmet = require('helmet');
const cors = require('cors');

let port = process.env.PORT || 3000;

app.use(helmet());
app.use(cors());

// temporary logging
app.use((req, res, next) => {
    console.log('%O', req);
    next();
   });

app.listen(port, () => {
    console.log('Virginia Elections API server listening on port ' + port);
});

app.use(bodyparser.urlencoded({ extended: false }));
app.use(bodyparser.json());

var routes = require('./routes/routes.js');
app.use('/', routes);