Client sends response (via URL and verb) and server responds (status Code + Message Body)


HTTP
stands for Hypertext Transfer Protocol which is a stateless, application-layer protocol for communicating between distributed systems, and is the foundation of the modern web. 
- communication usually takes place over TCP/IP  where the default port is 80. 
- communication b/w a host and client occurs via a request/response pair, where the client initiates an HTTP request message that is serviced through a HTTP response message in return.
The current version of the protocol is HTTP/1.1, which adds new features than the previous 1.0 version, including persistent connections, chucked transfer-coding and fine-grained cashing headers. 

URL - http://www.domain.com:1234/path/to/resource?a=b&x=y
		http => protocol
		www.domain.com => host
		:1234 => post
		path/to/resource => resource path
		?a=b&x=y => query

VERBS
URLs reveal the identity of the particular host with which we want to communicate, but the action that should be performed on the host is specified via HTTP verbs.
These request verbs are:

1. GET: fetch an existing resource. 
	The URL contains all the necessary information the server needs to locate and return the resource.
2. POST: create a new resource. 
	POST requests usually carry a payload that specifies the data for the new resource.
3. PUT: update an existing resource. 
	The payload may contain the updated data for the resource.
4. DELETE: delete an existing resource


There are some lesser used verbs that HTTP also supports:

1. HEAD: this is similar to GET, but without the message body. 
	It's used to retrieve the server headers for a particular resource, generally to check if the resource has changed, via timestamps.
2. TRACE: used to retrieve the hops that a request takes to round trip from the server. 
	Each intermediate proxy or gateway would inject its IP or DNS name into the Via header field. This can be used for diagnostic purposes.
3. OPTIONS: used to retrieve the server capabilities. 
	On the client-side, it can be used to modify the request based on what the server can support.


STATUS CODES
With URLs and verbs, the client can initiate requests to the server. In return, the server responds with status codes and message payloads. 
The status code is important and tells the client how to interpret the server response. 
The HTTP spec defines certain number ranges for specific types of responses


1xx: Informational Messages

This class of codes was introduced in HTTP/1.1 and is purely provisional. 
The server can send a Expect: 100-continue message, telling the client to continue sending the remainder of the request, or ignore if it has already sent it.
HTTP/1.0 clients are supposed to ignore this header.


2xx: Successful

This tells the client that the request was successfully processed. The most common code is 200 OK. 
For a GET request, the server sends the resource in the message body. There are other less frequently used codes:

202 Accepted: the request was accepted but may not include the resource in the response. This is useful for async processing on the server side. The server may choose to send information for monitoring.
204 No Content: there is no message body in the response.
205 Reset Content: indicates to the client to reset its document view.
206 Partial Content: indicates that the response only contains partial content. Additional headers indicate the exact range and content expiration information.


3xx: Redirection
This requires the client to take additional action. The most common use-case is to jump to a different URL in order to fetch the resource.

301 Moved Permanently: the resource is now located at a new URL.
303 See Other: the resource is temporarily located at a new URL. The Location response header contains the temporary URL.
304 Not Modified: the server has determined that the resource has not changed and the client should use its cached copy. This relies on the fact that the client is sending ETag (Enttity Tag) information that is a hash of the content. 
	The server compares this with its own computed ETag to check for modifications.


4xx: Client Error

These codes are used when the server thinks that the client is at fault, either by requesting an invalid resource or making a bad request. The most popular code in this class is 404 Not Found, which I think everyone will identify with. 404 indicates that the resource is invalid and does not exist on the server. The other codes in this class include:

400 Bad Request: the request was malformed.
401 Unauthorized: request requires authentication. The client can repeat the request with the Authorization header. If the client already included the Authorization header, then the credentials were wrong.
403 Forbidden: server has denied access to the resource.
405 Method Not Allowed: invalid HTTP verb used in the request line, or the server does not support that verb.
409 Conflict: the server could not complete the request because the client is trying to modify a resource that is newer than the client's timestamp. 
	Conflicts arise mostly for PUT requests during collaborative edits on a resource.

MESSAGE 
It's mandatory to place a new line between the message headers and body. 
The message can contain one or more headers, of which are broadly classified into:

1. General Headers 
There are a few headers (general headers) that are shared by both request and response messages:

general-header = Cache-Control            
               | Connection        
               | Date              
               | Pragma            
               | Trailer           
               | Transfer-Encoding 
               | Upgrade           
               | Via               
               | Warning

Via * header is used in a TRACE message and updated by all intermittent proxies and gateways
Pragma * is considered a custom header and may be used to include implementation-specific headers. The most commonly used pragma-directive is Pragma: no-cache, which really is Cache-Control: no-cache under HTTP/1.1. This will be covered in Part 2 of the article.
The Date header field * is used to timestamp the request/response message
Upgrade * is used to switch protocols and allow a smooth transition to a newer protocol.
Transfer-Encoding is generally used to break the response into smaller parts with the Transfer-Encoding: chunked value. This is a new header in HTTP/1.1 and allows for streaming of response to the client instead of one big payload.

2. Entity headers

Request and Response messages may also include entity headers to provide meta-information about the the content (aka Message Body or Entity). 
Custom headers can also be created and sent by the client; they will be treated as entity headers by the HTTP protocol.

These headers include:


entity-header  = Allow                    
               | Content-Encoding  
               | Content-Language  
               | Content-Length    
               | Content-Location  
               | Content-MD5       
               | Content-Range     
               | Content-Type      
               | Expires           
               | Last-Modified

All of the Content- prefixed headers provide information about the structure, encoding and size of the message body. Some of these headers need to be present if the entity is part of the message.

The Expires header indicates a timestamp of whent he entity expires. Interestingly, a "never expires" entity is sent with a timestamp of one year into the future. The Last-Modified header indicates the last modification timestamp for the entity.

3. Request Format
The request message has the same generic structure as above, except for the request line which looks like:


Request-Line = Method SP URI SP HTTP-Version CRLF
Method = "OPTIONS"
       | "HEAD"  
       | "GET"  
       | "POST"  
       | "PUT"  
       | "DELETE"  
       | "TRACE"
SP * is the space separator between the tokens. HTTP-Version is specified as "HTTP/1.1" and then followed by a new line. Thus, a typical request message might look like:


					GET /articles/http-basics HTTP/1.1
					Host: <span class="skimlinks-unlinked">www.articles.com</span>
					Connection: keep-alive
					Cache-Control: no-cache
					Pragma: no-cache
					Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
					Note the request line followed by many request headers. The Host header is mandatory for HTTP/1.1 clients. GET requests do not have a message body, but POST requests can contain the post data in the body.

The request headers act as modifiers of the request message. The complete list of known request headers is not too long, and is provided below. Unknown headers are treated as entity-header fields.


request-header = Accept                   
               | Accept-Charset    
               | Accept-Encoding   
               | Accept-Language   
               | Authorization     
               | Expect            
               | From              
               | Host              
               | If-Match          
               | If-Modified-Since 
               | If-None-Match     
               | If-Range          
               | If-Unmodified-Since
               | Max-Forwards       
               | Proxy-Authorization
               | Range              
               | Referer            
               | TE                 
               | User-Agent


  The Accept prefixed headers indicate the acceptable media-types, languages and character sets on the client. 
  From, Host, Referer and User-Agent identify details about the client that initiated the request. 
  The If- prefixed headers are used to make a request more conditional, and the server returns the resource only if the condition matches. 
  Otherwise, it returns a 304 Not Modified. The condition can be based on a timestamp or an ETag (a hash of the entity).

4. Response Format
The response format is similar to the request message, except for the status line and headers. The status line has the following structure:

	Status-Line = HTTP-Version SP Status-Code SP Reason-Phrase CRLF

		- HTTP-Version is sent as HTTP/1.1
		- The Status-Code is one of the many statuses discussed earlier.
		- The Reason-Phrase is a human-readable version of the status code.

A typical status line for a successful response might look like so:

			HTTP/1.1 200 OK


The response headers are also fairly limited, and the full set is given below:

			response-header = Accept-Ranges
			                | Age
			                | ETag              
			                | Location          
			                | Proxy-Authenticate
			                | Retry-After       
			                | Server            
			                | Vary              
			                | WWW-Authenticate
- Age is the time in seconds since the message was generated on the server.
- ETag is the MD5 hash of the entity and used to check for modifications.
- Location is used when sending a redirection and contains the new URL.
- Server identifies the server generating the message.

Ruby on Rails
Ruby on Rails
The request and response messages are mostly the same, except for the first line and message headers.

In Rails, the ActionController and ActionDispatch modules provide the API for handling request and response messages.

ActionController provides a high level API to read the request URL, render output and redirect to a different end-point. 
An end-point (aka route) is handled as an action method. 
Most of the necessary context information inside an action-method is provided via the request, response and params objects.

			params: gives access to the URL parameters and POST data.
			request: contains information about the client, headers and URL.
			response: used to set headers and status codes.
			render: render views by expanding templates.
			redirect_to: redirect to a different action-method or URL.

ActionDispatch provides fine-grained access to the request/response messages, via the ActionDispatch::Request and ActionDispatch::Response classes.
 It exposes a set of query methods to check the type of request (get?(), post?(), head?(), local?()). 
 Request headers can be directly accessed via the request.headers() method.

On the response side, it provides methods to set cookies(), location=() and status=(). 
If you feel adventurous, you can also set the body=() and bypass the Rails rendering system.
