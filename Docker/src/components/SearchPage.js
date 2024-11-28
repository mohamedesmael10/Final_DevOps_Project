import React, { Component } from 'react';
import * as BooksAPI from '../BooksAPI'
import BookItem from './BookItem';
import { Link } from 'react-router-dom';

class SearchPage extends Component {

    // Manage Adding, Query and notFound States
    state = {
        addBooks: [],
        query: [],
        notFound: false
    }

    // Updates The Query With The New State
    findBooks = e => {
        const query = e.target.value
        this.setState({query})

    // To Run Search Immediatly On (IF) User's Input
        if (query) {
            BooksAPI.search(query.trim(), 20).then((books) => {
                books.length > 0 ? this.setState({addBooks: books, notFound: false}) : this.setState({addBooks: [], notFound:true})
            })
        } else this.setState({addBooks: [], notFound: false})
    }

    render(){
        const { addBooks, query, notFound } = this.state
        const { books, changeShelfs } = this.props

        return(
            <div className="search-books">
                <div className="search-books-bar">
                    <Link to="/" className="close-search">Close</Link>
                    <div className="search-books-input-wrapper">
                    <input
                    type="text"
                    placeholder="Search by title or author"
                    value={query}
                    onChange={this.findBooks}/>
                    </div>
                </div>
                <div className="search-books-results">
                    {addBooks.length > 0 && (
                        <div>
                            <p>Number Of Books Found {addBooks.length} Book</p>
                            <ol className="books-grid">
                                {addBooks.map((book) => (
                                    <BookItem key={book.id} books={books} book={book} changeShelfs={changeShelfs} />
                                ))}
                            </ol>
                        </div>
                    )}
                    {/* If User's Input doesn't Match  The Search Terms */}
                    {notFound && (
                        <p>Please check what you wrote and try again.</p>
                    )}
                </div>
            </div>
        )
    }
}

export default SearchPage