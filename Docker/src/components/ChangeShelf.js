import React, { Component } from 'react'


class ChangeShelf extends Component {
    // When the value changes --> Update shelf state
    ShelfUpdate = e =>
    this.props.changeShelfs(this.props.book, e.target.value)

    render() {
        const {book, books} = this.props

        // If the Book is not added to any Shelf, Make shelf's value = none
        let defaultShelf = 'none'
        for (let item of books) {
            if (item.id === book.id) {
                defaultShelf = item.shelf
                break
            }
        }

        return (
            <div className="book-shelf-changer">
                <select onChange={this.ShelfUpdate} defaultValue={defaultShelf}>
                    <option disabled>
                        Move to...
                    </option>
                    <option value="currentlyReading">Currently Reading</option>
                    <option value="wantToRead">Want to Read</option>
                    <option value="read">Read</option>
                    <option value="none">None</option>
                </select>
            </div>
        )
    }
}

export default ChangeShelf