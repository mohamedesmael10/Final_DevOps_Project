import React from 'react'
import BookItem from './BookItem'

const BooksShelves = (props) => {

  const { books, changeShelfs } = props

  return(
    <ol className="books-grid">
      {books.map((book) => (
        <BookItem
          key={book.id}
          book={book}
          books={books}
          changeShelfs={changeShelfs}
        />
      ))}
    </ol>
  )
}

export default BooksShelves