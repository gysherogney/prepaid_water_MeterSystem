const express = require("express");
const axios = require("axios");
const fs = require("fs");
const app = express();

app.get("/:ip/:mac", async (req, res) => {
    const { ip, mac } = req.params;

    const data = {
        ip: ip,
        mac: mac,
    };

    try {
        const response = await axios.post(
            "https://isp.momobando.com/api/user-connected",
            data,
            {
                headers: {
                    Accept: "application/json",
                },
            }
        );

        logData(
            `Sent to: ${data.recipient}, Message: ${text}, Response: ${response.data}`
        );
        res.send(response.data);
    } catch (error) {
        const errorMsg = `Error: ${error.message}`;
        logData(errorMsg);
        res.status(500).send(errorMsg);
    }
});

app.get("/rebooted", async (req, res) => {
    try {
        const response = await axios.get(
            "https://isp.momobando.com/api/rebooted",

            {
                headers: {
                    Accept: "application/json",
                },
            }
        );

        res.send(response.data);
    } catch (error) {
        const errorMsg = `Error: ${error.message}`;
        logData(errorMsg);
        res.status(500).send(errorMsg);
    }
});

function logData(message) {
    const logFile = "sms_log.txt";
    const currentDate = new Date().toISOString();
    const logMessage = `${currentDate} - ${message}\n`;

    fs.appendFileSync(logFile, logMessage);
}

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
