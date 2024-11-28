import React, { Component } from 'react';
import ContentOfBooksList from './ContentOfBooksList';
import Header from './Header';
import SearchButton from './SearchButton';

class BooksList extends Component {


    render() {

        const { books, changeShelfs } = this.props


        return(
            <div className="list-books">

            <Header />

            <ContentOfBooksList books={books} changeShelfs={changeShelfs} />

            <SearchButton />

            </div>
        )
    }
}

export default BooksList