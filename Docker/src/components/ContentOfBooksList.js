import React from 'react';
import BooksShelves from './BooksShelves';

const ContentOfBooksList = (props) => {

    const { books, changeShelfs } = props
    const shelfNames = [
        {key: "currentlyReading", title: "Currently Reading"},
        {key: "wantToRead", title: "Want To Read"},
        {key: "read", title: "Read"}
    ]

    return (
        <div className="list-books-content">
        {shelfNames.map((shelf, index) => {
            // Filter Catagorised Books Only
            const booksOfShelf = books.filter((book) => book.shelf === shelf.key)
            return(
                <div className="bookshelf" key={index}>
                    <h2 className="bookshelf-title">{shelf.title}</h2>
                    <div className="bookshelf-books">
                    <BooksShelves books={booksOfShelf} changeShelfs={changeShelfs} />
                    </div>
                </div>
            )
        })}
        </div>
    )
}

export default ContentOfBooksList