;; title: akcoin
;; version: 1.0.0
;; summary: Minimal Akcoin contract
;; description: A simple Akcoin contract that tracks an owner and a total supply.

;; -----------------------------------------------------------------------------
;; constants
;; -----------------------------------------------------------------------------

(define-constant TOKEN_NAME (some "Akcoin"))
(define-constant TOKEN_SYMBOL (some "AKC"))
(define-constant TOKEN_DECIMALS u6)

(define-constant ERR_UNAUTHORIZED u100)

;; -----------------------------------------------------------------------------
;; data vars
;; -----------------------------------------------------------------------------

;; Contract owner (the deployer of this contract)
(define-data-var owner principal tx-sender)

;; Total supply of AKC that has been minted / configured
(define-data-var total-supply uint u0)

;; -----------------------------------------------------------------------------
;; read-only functions
;; -----------------------------------------------------------------------------

(define-read-only (get-name)
  TOKEN_NAME)

(define-read-only (get-symbol)
  TOKEN_SYMBOL)

(define-read-only (get-decimals)
  TOKEN_DECIMALS)

(define-read-only (get-owner)
  (var-get owner))

(define-read-only (get-total-supply)
  (var-get total-supply))

;; -----------------------------------------------------------------------------
;; public functions
;; -----------------------------------------------------------------------------

;; Set the total supply. Only the contract owner may call this.
(define-public (set-total-supply (amount uint))
  (if (is-eq tx-sender (var-get owner))
      (begin
        (var-set total-supply amount)
        (ok true))
      (err ERR_UNAUTHORIZED)))
