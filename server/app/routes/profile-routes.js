const router = require('express').Router();

const authCheck = (req, res, next) => {
    if(!req.user){
        // if user is not logged in
        res.redirect('/auth/login');
    }
    else{
        // if logged in
        next();
    }
};

router.get('/', authCheck, (req, res) => {
    console.log("Req user: " + JSON.stringify(req.user));
    res.send('you are logged in, this is your profile - ' + req.user[0].email);
});

module.exports = router;