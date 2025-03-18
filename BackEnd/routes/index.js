const express = require('express');
const router = express.Router();

const authController = require('../services/auth/auth');
const userController = require('../controllers/userController');

const paymentController = require('../controllers/paymentCRUD');
const reviewController = require('../controllers/reviewCRUD');
const wishlistController = require('../controllers/wishlistCRUD');
const questionController = require('../controllers/questionCRUD');
const addressController = require('../controllers/addressCRUD');
const brandController = require('../controllers/brandCRUD');
const categoryController = require('../controllers/categoryCRUD');
const couponCodeController = require('../controllers/coupon_codeCRUD');
const homeController = require('../controllers/homeCRUD');
const orderController = require('../controllers/orderCRUD');
const productController = require('../controllers/productCRUD');



// User routes
router.post('/users', userController.createUser);
router.get('/users/:id', userController.getUser);
router.get('/users', userController.getAllUsers);
router.put('/users/:id', userController.updateUser);
router.delete('/users/:id', userController.deleteUser);


// Address routes
router.post('/addresses', addressController.createAddress);
router.get('/addresses/:id', addressController.getAddress);
router.get('/addresses', addressController.getAllAddresses);
router.put('/addresses/:id', addressController.updateAddress);
router.delete('/addresses/:id', addressController.deleteAddress);

// Brand routes
router.post('/brands', brandController.createBrand);
router.get('/brands/:id', brandController.getBrand);
router.get('/brands', brandController.getAllBrands);
router.put('/brands/:id', brandController.updateBrand);
router.delete('/brands/:id', brandController.deleteBrand);

// Category routes
router.post('/categories', categoryController.createCategory);
router.get('/categories/:id', categoryController.getCategory);
router.get('/categories', categoryController.getAllCategories);
router.put('/categories/:id', categoryController.updateCategory);
router.delete('/categories/:id', categoryController.deleteCategory);

// Coupon Code routes
router.post('/coupons', couponCodeController.createCouponCode);
router.get('/coupons/:id', couponCodeController.getCouponCode);
router.get('/coupons', couponCodeController.getAllCouponCodes);
router.put('/coupons/:id', couponCodeController.updateCouponCode);
router.delete('/coupons/:id', couponCodeController.deleteCouponCode);

// Featured Product routes
router.post('/featured-products', homeController.createFeaturedProduct);
router.get('/featured-products/:id', homeController.getFeaturedProduct);
router.get('/featured-products', homeController.getAllFeaturedProducts);
router.delete('/featured-products/:id', homeController.deleteFeaturedProduct);

// New Product routes
router.post('/new-products', homeController.createNewProduct);
router.get('/new-products/:id', homeController.getNewProduct);
router.get('/new-products', homeController.getAllNewProducts);
router.delete('/new-products/:id', homeController.deleteNewProduct);

// Offer routes
router.post('/offers', homeController.createOffer);
router.get('/offers/:id', homeController.getOffer);
router.get('/offers', homeController.getAllOffers);
router.put('/offers/:id', homeController.updateOffer);
router.delete('/offers/:id', homeController.deleteOffer);

// Order routes
router.post('/orders', orderController.createOrder);
router.get('/orders/:id', orderController.getOrder);
router.get('/orders', orderController.getAllOrders);
router.put('/orders/:id', orderController.updateOrder);
router.delete('/orders/:id', orderController.deleteOrder);

// Payment routes
router.post('/payments', paymentController.createPayment);
router.get('/payments/:id', paymentController.getPayment);
router.get('/payments', paymentController.getAllPayments);
router.put('/payments/:id', paymentController.updatePayment);
router.delete('/payments/:id', paymentController.deletePayment);

// Product routes
router.post('/products', productController.createProduct);
router.get('/products/:id', productController.getProduct);
router.get('/products', productController.getAllProducts);
router.put('/products/:id', productController.updateProduct);
router.delete('/products/:id', productController.deleteProduct);
// Address routes
router.post('/addresses', addressController.createAddress);
router.get('/addresses/:id', addressController.getAddress);
router.get('/addresses', addressController.getAllAddresses);
router.put('/addresses/:id', addressController.updateAddress);
router.delete('/addresses/:id', addressController.deleteAddress);

// Payment routes
router.post('/payments', paymentController.createPayment);
router.get('/payments/:id', paymentController.getPayment);
router.get('/payments', paymentController.getAllPayments);
router.put('/payments/:id', paymentController.updatePayment);
router.delete('/payments/:id', paymentController.deletePayment);


// Review routes
router.post('/reviews', reviewController.createReview);
router.get('/reviews/:id', reviewController.getReview);
router.get('/reviews', reviewController.getAllReviews);
router.put('/reviews/:id', reviewController.updateReview);
router.delete('/reviews/:id', reviewController.deleteReview);

// Wishlist routes
router.post('/wishlists', wishlistController.createWishlist);
router.get('/wishlists/:id', wishlistController.getWishlist);
router.get('/wishlists', wishlistController.getAllWishlists);
router.put('/wishlists/:id', wishlistController.updateWishlist);
router.delete('/wishlists/:id', wishlistController.deleteWishlist);

// Question routes
router.post('/questions', questionController.createQuestion);
router.get('/questions/:id', questionController.getQuestion);
router.get('/questions', questionController.getAllQuestions);
router.put('/questions/:id', questionController.updateQuestion);
router.delete('/questions/:id', questionController.deleteQuestion);

// Answer routes
router.post('/answers', questionController.createAnswer);   
router.get('/answers/:id', questionController.getAnswer);
router.get('/answers', questionController.getAllAnswers);
router.put('/answers/:id', questionController.updateAnswer);
router.delete('/answers/:id', questionController.deleteAnswer);


router.post('/register', authController.register);

router.post('/login', authController.login);

router.post('/forget-password', authController.forgetPassword);



module.exports = router;