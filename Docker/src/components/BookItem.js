import React from 'react';
import ChangeShelf from './ChangeShelf';

const BookItem = (props) => {
    const { book, books, changeShelfs } = props

    const title = book.title ? book.title : 'No title';

    const coverImage = book.imageLinks && book.imageLinks.thumbnail ? book.imageLinks.thumbnail : "No Cover Found"

    return (
        <li>
            <div className="book">
                <div className="book-top book-cover" style={{ backgroundImage: `url(${coverImage})` }}>
                    <ChangeShelf book={book} books={books} changeShelfs={changeShelfs} />
                </div>
                <div className="book-title">{title}</div>
            {
            book.authors &&
            book.authors.map((author, index) => (
                <div className="book-authors" key={index}>
                        {author}
                </div>
            ))}
            </div>
        </li>
    );
};

export default BookItem