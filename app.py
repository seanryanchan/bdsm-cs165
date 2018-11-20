from flask import Flask, render_template
from data import Content
from flask import url_for

app = Flask(__name__)

Content = Content()

@app.route('/')
def index():
    return render_template('home.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/content')
def content():
    return render_template('content.html', content = Content)


if __name__ == '__main__':
    app.run(debug=True)
