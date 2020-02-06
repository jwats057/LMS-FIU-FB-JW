const router = require('express').Router();
const passport = require('passport');


// auth login
router.get('/login', (req, res) => {
    res.send('login');
    console.log("HELLO LOGIN");
});

// auth logout
router.get('/logout', (req, res) => {
    // handle with passport
    res.send('logging out');
    req.logout();
});

// auth with facebook
router.get('/facebook', passport.authenticate('facebook', { scope: ['email'] }));

const options = {
    successRedirect: '/',
    failureRedirect: '/auth/login'
}
router.get('/facebook/redirect', passport.authenticate('facebook'), (req, res) => {
    res.redirect('/profile/');
});


module.exports = router;
