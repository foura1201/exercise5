const express = require('express');
const { runQuery } = require('./database');
const app = express();
const port = 3000;

app.use(express.urlencoded({ extended: true }));

app.get('/fare', (req, res) => {
    const {uid} = req.query;
    (async () => {
        const fare = getFare(uid);
        console.dir(uid);
    })();
    res.send(`Total fare of `);
});

app.get('/train/status', (req, res) => {
    const {tid} = req.query;
    res.sendFile(__dirname + "/login.html");
});

app.post('/login', (req, res) => {
    const {username, password} = req.body;
    res.send(`username: ${username}<br>password: ${password}`);
})

app.listen(port, () => console.log(`Server listening on port ${port}!`));

const getScoreStats = async () => {
    const sql =  'SELECT course, Count(*) as cnt, Avg(midterm) as avg, ' +
                 'Stddev(midterm) as stddev FROM scores GROUP BY course';
    const results = await runQuery(sql);
    return results;
};

const getFare = async (uid) => {
    const sql = `SELECT sum(round(ty.fare_rate*tr.distance/1000)) as total_fare from trains as tr `+
                `inner join types as ty on tr.type=ty.id `+
                `inner join tickets as t on t.train=tr.id `+
                `inner join users as u on t.user=u.id and u.id=? group by u.id;`
    const result = await runQuery(sql, [uid]);
    return result;
}

(async () => {
    const stats = await getScoreStats();
    console.dir(stats);

    const ScoreData = await getScoreByIdName(2, 'joe');
    console.dir(ScoreData);

    const result = await createScore('Barack', 'Operationg System', 83, 23);
    console.dir(result);

})();