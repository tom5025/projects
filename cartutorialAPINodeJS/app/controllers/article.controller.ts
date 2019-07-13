const Article = require('../model/Article.model');
import * as express from 'express';
import * as bodyParser from 'body-parser';

export default class ArticleController{
    public path = '/article';
    public router = express.Router();

    constructor(){
        this.initializeRoutes();
    }

    public initializeRoutes()
    {
        this.router.post(this.path, this.ArticleCreate)
    }

    ArticleCreate =function(req : express.Request, res : express.Response){
        let Article = new Article({
            name:req.body.name,
            price:req.body.price
        });
    
        Article.save(function (err){
            if (err)
            {
                return next(err);
            }
            res.send('Article created successfully');
        })
    };
}


exports.Article_create = 

exports.Article_details = function (req, res){
    Article.findById(req.params.id, function(err, Article){
        if (err) return next(err);
        res.send(Article);
    });
};

exports.Article_update = function(req, res){
    Article.findByIdAndUpdate(req.params.id, {$set:req.body},
    function(err,Article){
        if (err) return next(err);
        res.send('Article updated');
    });
};

exports.Article_delete = function (req, res) {
    Article.findByIdAndRemove(req.params.id, function (err) {
        if (err) return next(err);
        res.send('Deleted successfully!');
    })
};
