# README

* Ruby Version: 2.3.1

* Rails Version: 5.0.0.1

* To use:
    * 1) git clone https://github.com/tgisg/filedrop
    * 2) bundle install
    * 3) rake db:create db:migrate (to create the database and schema)
    * 4) testing: rspec

CONTRIBUTORS:
* [Bryan Goss](https://github.com/bcgoss)
* [Sonia Gupta](https://github.com/tgisg)
* [Jasmin Hudacsek](https://github.com/j-sm-n)
* [Matt DesMarteau](https://github.com/MDes41)

------------------------------------------------
<span style="color:#ffff; font-family: 'Courier'; font-size: 3em;">
FileDrop API</span>

  * Version: 1.0.0
  * Description: *This API allows you to create, read, update, and delete comments on FileDrop documents.*

    **Find source code of this API** [here](https://github.com/tgisg/filedrop)
  * Host: filedrop-v1.herokuapp.com
  * Base Path: /api/v1/comments
      * schemes:
          - http
          - https
      * consumes:
          - application/json
      * produces:
          - application/json
  * paths:

    **GET /?api_key[API-KEY]&document_id=[DOCUMENT_ID]**

    Parameters:
        document_id: The document for which you would like to see comments
    Response:
        message: Array of all the comments associated with the document

    **GET /comment_id[COMMENT_ID]?api_key[API-KEY]&document_id=[DOCUMENT_ID]**

    Parameters:
        document_id: The document which contains the comment you would like to see
        user_id: The user who made the comment
        comment_id: The comment you would like to see
    Response:
        message: A comment

    **POST /?api_key[API-KEY]&document_id=[DOCUMENT_ID]&user_id=[USER_ID]&content=[CONTENT]**

      Parameters:
        document_id: The document upon which you are commenting
        user_id: The user making a comment
        content: The content of the comment being posted
      Response:
        message: "A comment was created!"

    **PUT /comment_id=[COMMENT_ID]?api_key[API-KEY]&document_id=[DOCUMENT_ID]&content=[CONTENT]**

      Parameters:
        document_id: The document whose comment you're editing
        user_id: The id of the user editing the comment
        comment_id: The comment being edited
        content: The content of the comment being edited
      Response:
        message: "The comment was edited!"

    **DELETE /comment_id=[COMMENT_ID]?api_key[API-KEY]&document_id=[DOCUMENT_ID]**

      Parameters:
        document_id: The document whose comment you're deleting
        user_id: The id of the user deleting the comment
        comment_id: The comment being deleted
        content: The content of the comment being edited
      Response:
        message: "The comment was edited!"
