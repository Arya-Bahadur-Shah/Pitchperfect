package pitchperfect.exception;

/**
 * ApplicationException is propagated from Service classes when a business
 * logic exception occurred.
 * 
 * @author Navigable Set
 * @version 1.0
 * @Copyright (c) Navigable Set
 */
public class ApplicationException extends Exception {

    /**
     * Constructor with message
     * 
     * @param msg : Error message
     */
    public ApplicationException(String msg) {
        super(msg);
    }

    /**
     * Constructor with message and cause (original exception)
     * 
     * @param msg   : Error message
     * @param cause : Original exception (Throwable)
     */
    public ApplicationException(String msg, Throwable cause) {
        super(msg, cause); // Pass the message and cause to the superclass
    }
}
