
## PROJECT NODE.JS USING TERRAFORM
This project entails the provisioning of a Docker container and inside that image container is a node.js application showing
"hello world" on the browser once the its deployed




first it entails the creation of an app.js or the default page as shown below with the code

const express = require('express')

const app = express()

const port = 8080 

app.get('/', (req, res) => res.send('Welcome to my page!')) 

app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`))
