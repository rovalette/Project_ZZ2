#ifndef POOL_HPP
#define POOL_HPP

/*!
 * \file Pool.hpp
 * \brief Définition de la classe Pool.
 */

#include <list>
#include <functional>
#include <algorithm>

template <typename T>
/*!
 * \struct func_delete
 * 
 * Foncteur qui supprime l'élément qui lui est passé en paramètre.
 */
struct func_delete : public std::unary_function< T, void> {
	void operator()(T * t);
};

template <typename T>
/*!
 * \class Pool
 * \brief Implémente le design pattern Pool.
 * 
 * Cette classe template permet le recyclage d'objet. On peut donner à 
 * la pool le nombre maximal d'objet qu'elle peut stocker. Lorsque ce 
 * nombre est atteint, la pool commence à supprimer des objets.
 * Attention, lorsqu'on utilise la pool, il ne faut pas oublié de la 
 * supprimer : 
 * delete Pool<T>::instance();
 */
class Pool {
	protected:
	unsigned int m_tailleMax; /*!< Nombre maximal d'objet dans la pool. */
	std::list<T*> m_fifo; /*!< File contenant les objets. */
	
	static Pool<T> * _instance; /*!< Instance du singleton. */
	
	/*!
	 * \brief Constructeur.
	 * 
	 * La pool étant un singleton, le constructeur est privé.
	 */
	Pool();
	
	public:
	/*!
	 * \brief Méthode de classe qui retourne l'instance du singleton.
	 * \return un pointeur sur la pool désirée.
	 * 
	 * Si l'instance n'existait pas encore, elle serait créée.
	 */
	static Pool<T> * instance();
	/*!
	 * \brief Destructeur.
	 * 
	 * Détruit la file d'objet.
	 */
	~Pool();
	/*!
	 * \brief Donne un élément.
	 * 
	 * Si la pool est vide, l'élément est créé.
	 * 
	 * \return un élément.
	 */
	T * get();
	/*!
	 * \brief Rend un élément à la pool.
	 * 
	 * Si la pool est pleine, on supprime cet élément.
	 * 
	 * \param t : l'élément rendu.
	 */
	void give_back(T * t);
	/*!
	 * \brief Modifie la taille maximale de la pool.
	 * \param size : la nouvelle taille.
	 */
	void setSize(const unsigned int& size);
	/*!
	 * \brief Retourne la taille de la file contenant les objets.
	 * \return la taille.
	 */
	unsigned int size();
	/*!
	 * \brief Supprime tous les éléments de la pool.
	 */
	void clear();
};

// func_delete : operator()
template <typename T>
void func_delete<T>::operator()(T * t) {
	delete t;
}

// initialisation de l'instance à 0.
template <typename T>
Pool<T> * Pool<T>::_instance = 0;

// constructeur
template <typename T>
Pool<T>::Pool() : m_tailleMax(0) {
	
}

// instance
template <typename T>
Pool<T> * Pool<T>::instance() {
	if ( !_instance ) {
		_instance = new Pool<T>;
	}
	
	return _instance;
}

// destructeur
template <typename T>
Pool<T>::~Pool() {
	for_each(m_fifo.begin(), m_fifo.end(), func_delete<T>());
}

// get
template <typename T>
T * Pool<T>::get() {
	if ( m_fifo.empty() ) {
		return new T();
	}
	else {
		T * t = m_fifo.front();
		m_fifo.pop_front();
		return t;
	}
}

// give_back
template <typename T>
void Pool<T>::give_back(T * t) {
	if ( m_fifo.size() >= m_tailleMax ) {
		delete t;
	}
	else {
		m_fifo.push_back(t);
	}
}

// setSize
template <typename T>
void Pool<T>::setSize(const unsigned int& size) {
	m_tailleMax = size;
}

// size
template <typename T>
unsigned int Pool<T>::size() {
	return m_fifo.size();
}

// size
template <typename T>
void Pool<T>::clear() {
	for_each(m_fifo.begin(), m_fifo.end(), func_delete<T>());
	
	m_fifo.clear();
}

#endif
