const Question = require('../models/question').Question;
const AnswerQuestion = require('../models/question').AnswerQuestion;

exports.createQuestion = async (req, res) => {
    try {
        const question = new Question(req.body);
        await question.save();
        res.status(201).send(question);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getQuestion = async (req, res) => {
    try {
        const question = await Question.findById(req.params.id);
        if (!question) return res.status(404).send('question not found');
        res.send(question);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllQuestions = async (req, res) => {
    try {
        const question = await Question.find();
        res.send(question);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateQuestion = async (req, res) => {
    try {
        const question = await Question.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!question) return res.status(404).send('question not found');
        res.send(question);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteQuestion= async (req, res) => {
    try {
        const question = await Question.findByIdAndDelete(req.params.id);
        if (!question) return res.status(404).send('question not found');
        res.send(question);
    } catch (error) {
        res.status(500).send(error);
    }
};

// ****************************************************************
// ****************************************************************
// ****************************************************************
// ****************************************************************

exports.createAnswer = async (req, res) => {
    try {
        const answer = new AnswerQuestion(req.body);
        await answer.save();
        res.status(201).send(answer);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getAnswer = async (req, res) => {
    try {
        const answer = await AnswerQuestion.findById(req.params.id);
        if (!answer) return res.status(404).send('answer not found');
        res.send(answer);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllAnswers = async (req, res) => {
    try {
        const answer = await AnswerQuestion.find();
        res.send(answer);
    } catch (error) {
        res.status(500
        ).send(error);
    }
};


exports.updateAnswer = async (req, res) => {
    try {
        const answer = await AnswerQuestion.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!answer) return res.status(404).send('answer not found');
        res.send(answer);
    } catch (error) {
        res.status(400).send(error);
    }
};


exports.deleteAnswer= async (req, res) => {
    try {
        const answer = await AnswerQuestion.findByIdAndDelete(req.params.id);
        if (!answer) return res.status(404).send('answer not found');
        res.send(answer);
    } catch (error) {
        res.status(500).send(error);
    }
};



