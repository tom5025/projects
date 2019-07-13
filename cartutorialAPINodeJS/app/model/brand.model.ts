import mongoose = require('mongoose');
const Schema = mongoose.Schema;

let BrandSchema = new Schema({
     id:{type: Number},
     name:{type : String, required:true, max:100},     
});

module.exports = mongoose.model('Brand', BrandSchema);
