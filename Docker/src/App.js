import React, {Component} from "react";
import { Route } from "react-router-dom";
import * as BooksAPI from './BooksAPI'
import "./App.css";
import SearchPage from "./components/SearchPage";
import BooksList from "./components/BooksList";

class BooksApp extends Component {

  state = {
    books: []
  };

  changeShelfs = (changedBook, shelf) => {
    BooksAPI.update(changedBook, shelf).then(response => {
      // Update Book State
      changedBook.shelf = shelf;
      this.setState(prevState => ({
        books: prevState.books
          .filter(book => book.id !== changedBook.id)
          .concat(changedBook)
      }));
    });
  };

  // Get All Books When Load
  componentDidMount() {
    BooksAPI.getAll().then(books => this.setState({ books }));
  }

  render() {
    const { books } = this.state

    return (
      // The Main APP Component
      <div className="app">

        {/* Search Page Component */}
        <Route
          exact path="/search"
          render={() => (
            <SearchPage books={books} changeShelfs={this.changeShelfs} />
          )} />

        {/* Books List Component */}
        <Route
        exact path="/"
        render={() => (
          <BooksList books={books} changeShelfs={this.changeShelfs} />
        )} />

      </div>
    );
  }
}

export default BooksApp;
