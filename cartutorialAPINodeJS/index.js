var express = require('express');
var hostname = 'localhost';
var port = 3000;
var mongoose = require('mongoose');
var options = { server: { socketOptions: { keepAlive: 300000, connectTimeoutMS: 30000 } },
                replset: { socketOptions: { keepAlive: 300000, connectTimeoutMS : 30000 } } };
var urlmongo = "mongodb://userfrugal:passwordfrugal@ds151108.mlab.com:51108/restfrugaldb";
mongoose.connect(urlmongo, options);
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'Erreur lors de la connexion'));
db.once('open', function (){
    console.log("Connexion à la base OK");
});
var app = express();
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
var piscineSchema = mongoose.Schema({
    nom: String,
    adresse: String,
    tel: String,
    description: String
});
var Piscine = mongoose.model('Piscine', piscineSchema);
var myRouter = express.Router();
myRouter.route('/')
.all(function(req,res){
      res.json({message : "Bienvenue sur notre Frugal API ", methode : req.method});
});

myRouter.route('/piscines')
.get(function(req,res){
	Piscine.find(function(err, piscines){
        if (err){
            res.send(err);
        }
        res.json(piscines);
    });
})
.post(function(req,res){
      var piscine = new Piscine();
      piscine.nom = req.body.nom;
      piscine.adresse = req.body.adresse;
      piscine.tel = req.body.tel;
      piscine.description = req.body.description;
      piscine.save(function(err){
        if(err){
          res.send(err);
        }
        res.json({message : 'Bravo, la piscine est maintenant stockée en base de données'});
      });
});

myRouter.route('/piscines/:piscine_id')
.get(function(req,res){
            Piscine.findById(req.params.piscine_id, function(err, piscine) {
            if (err)
                res.send(err);
            res.json(piscine);
        });
})
.put(function(req,res){
                Piscine.findById(req.params.piscine_id, function(err, piscine) {
                if (err){
                    res.send(err);
                }
                        piscine.nom = req.body.nom;
                        piscine.adresse = req.body.adresse;
                        piscine.tel = req.body.tel;
                        piscine.description = req.body.description;
                              piscine.save(function(err){
                                if(err){
                                  res.send(err);
                                }
                                res.json({message : 'Bravo, mise à jour des données OK'});
                              });
                });
})
.delete(function(req,res){

    Piscine.remove({_id: req.params.piscine_id}, function(err, piscine){
        if (err){
            res.send(err);
        }
        res.json({message:"Bravo, piscine supprimée"});
    });

});
app.use(myRouter);
app.listen(port, hostname, function(){
	console.log("Mon serveur fonctionne sur http://"+ hostname +":"+port);
});
