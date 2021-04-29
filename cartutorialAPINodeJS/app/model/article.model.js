const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let ArticleSchema = new Schema({
     id:{type: Number, required:true},
     brandId:{type : Number, required:true},     
     catId : {type: Number, required:true},
     title : {type: String, required : true},
     toolsNeeded:{ type :String},
     level : {type:String},
     makeModel : {type : String},
     contents : { type:string}
});

module.exports = mongoose.model('Article', ArticleSchema);
