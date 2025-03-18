const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const questionSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    title: { type: String, required: true },
    question: { type: String, required: true },
}, { timestamps: true });

const answerSchema = new Schema({
    question: { type: Schema.Types.ObjectId, ref: 'Question', required: true },
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    answer: { type: String, required: true },
    isCorrect: { type: Boolean, default: false }
}, { timestamps: true });

const Question = model('Question', questionSchema);
const Answer = model('Answer', answerSchema);

module.exports = { Question, Answer };