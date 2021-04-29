import Brand = require('../model/brand.model');

//Simple version, without validation or sanitation
exports.test = function (req, res) {
    res.send('Greetings from the Test controller!');
};

exports.brand_create = function(req, res){
    let brand = new brand({
        name:req.body.name,
        price:req.body.price
    });

    brand.save(function (err){
        if (err)
        {
            return next(err);
        }
        res.send('brand created successfully');
    })
};

exports.brand_details = function (req, res){
    brand.findById(req.params.id, function(err, brand){
        if (err) return next(err);
        res.send(brand);
    });
};

exports.brand_update = function(req, res){
    brand.findByIdAndUpdate(req.params.id, {$set:req.body},
    function(err,brand){
        if (err) return next(err);
        res.send('brand updated');
    });
};

exports.brand_delete = function (req, res) {
    brand.findByIdAndRemove(req.params.id, function (err) {
        if (err) return next(err);
        res.send('Deleted successfully!');
    })
};
