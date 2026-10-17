from flask import Flask, jsonify
import socket

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify(message="It's not a test",
                   pod=socket.gethostname())

@app.route('/health')
def health():
    return "ok"