<span style="color:#ffff; font-family: 'Courier'; font-size: 4em;">
FileDrop</span>

  * Version: 1.0.0
  * Description: *This API allows you to create, read, update, and delete comments on FileDrop documents.*

    **Find source code of this API** [here](https://github.com/tgisg/filedrop)
  * Host: filedrop-v1.herokuapp.com/
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

    **POST /?api_key[API-KEY]&document_id=[DOCUMENT_ID]&user_id=[USER_ID]&content=[CONTENT]**

      Parameters:
        document_id: The document upon which you are commenting
        user_id: The user making a comment
        content: The content of the comment being posted
      Response:
        message: "A comment was created!"

    **PUT /?api_key[API-KEY]&document_id=[DOCUMENT_ID]&user_id=[USER_ID]&comment_id=[COMMENT_ID]&content=[CONTENT]**

      Parameters:
        document_id: The document whose comment you're editing
        user_id: The id of the user editing the comment
        comment_id: The comment being edited
        content: The content of the comment being edited
      Response:
        message: "The comment was edited!"

    **DELETE /?api_key[API-KEY]&document_id=[DOCUMENT_ID]&user_id=[USER_ID]&comment_id=[COMMENT_ID]**

      Parameters:
        document_id: The document whose comment you're deleting
        user_id: The id of the user deleting the comment
        comment_id: The comment being deleted
        content: The content of the comment being edited
      Response:
        message: "The comment was edited!"
